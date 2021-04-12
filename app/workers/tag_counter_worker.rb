class TagCounterWorker
  include Sidekiq::Worker

  sidekiq_options lock: :while_executing, lock_timeout: 30, lock_ttl: 10.seconds.to_i

  def perform
    # Please Change that URL into a environmental variable
    uri = URI.parse('https://webhook.site/526c9190-3486-406b-8ae3-ebec4121adb1')
    popular_tag = Tag.all.order(tickets_count: :desc).first
    body = { tag: popular_tag.title, mentions: popular_tag.tickets_count }

    http = Net::HTTP.new(uri.host, uri.port)
    http.post(uri, body.to_json)
  end
end
