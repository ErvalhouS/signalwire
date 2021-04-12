# frozen_string_literal: true

module Api
  module V1
    class TicketsController < ActionController::API
      # @route POST /tickets (tickets)
      def create
        Tag.transaction do
          tags = ticket_params[:tags]&.uniq&.reject(&:empty?)&.map do |tag|
            Tag.find_or_create_by(title: tag.downcase)
          end
          @ticket = Ticket.create(ticket_params.merge(tags: tags))

          if @ticket.valid?
            TagCounterWorker.perform_async
            render json: @ticket, include: {:tags => {:only => :title}}, status: :created
          else
            render json: @ticket.errors.messages, status: :unprocessable_entity
          end
        end
      end

      private

      def ticket_params
        params.permit(:title, :user_id, tags: [])
      end
    end
  end
end
