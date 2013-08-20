Question.where('user_id in (:ids) or target in (:usernames)', 
               :ids => self.friends.ids, :usernames => self.friends.usernames)

Question.where('user_id in (?) or target in (?)', 
               self.friends.ids, self.friends.usernames)
