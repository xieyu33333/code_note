  def self.created_by(topic)
    # MEMORY table, no transaction
    ct = find_or_initialize_by_topic_id topic.id
    ct.forum = topic.forum
    ct.last_post_id = topic.last_post_id
    ct.save!
  end

  def self.approved_with(ids, admin)
    Topic.transaction do
      topics = Topic.where(:id => ids, :status => [Status::SPAM, Status::PENDDING, Status::EDIT_PENDDING])
        .select('id, topic_detail_id, status, forum_id, last_post_id').all
      if topics.any?
        t_ids = topics.map(&:id)
        td_ids = topics.map(&:topic_detail_id)
        spam_topics = topics.select{|t| t.status == Status::SPAM}
        spam_topics.each{|t| OpenTopic.created_by(t)} unless spam_topics.empty?
        Topic.where(:id => t_ids).update_all :status => Status::APPROVED
        TopicDetail.where(:id => td_ids).update_all :approver_id => admin.id, :approved_at => Time.now
        t_ids.each{|id| Topic.expire_second_level_cache(id)}
        td_ids.each{|id| TopicDetail.expire_second_level_cache(id)}
      end
    end
  end
