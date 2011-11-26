module LinksHelper

  def get_mutual_friends(current_user, is_owner, conversation=nil)
    mutual_friends = []
    @graph = Koala::Facebook::API.new(current_user.authorizations.first['token'])
    if not is_owner
      mutual_friends = @graph.get_connections("me", "mutualfriends/" + @link.owner.authorizations.first['uid'])
    else
      other_user = conversation.get_other_user(current_user)
      if not other_user.nil?
        mutual_friends = @graph.get_connections("me", "mutualfriends/" + other_user.authorizations.first['uid'])
      end
    end
    mutual_friends.each do |friend|
      friend['picture_url'] = @graph.get_picture(friend['id'])
    end
    
    return mutual_friends
  end
end
