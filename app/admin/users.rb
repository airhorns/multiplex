ActiveAdmin.register User do
  #column "Title", :sortable => :title do |post| 
    #link_to post.title, admin_post_path(post)
  #end
  
  index do
    column :id
    column :email
    column :mask_email, :sortable => false
    column :summary_frequency
    column :enabled
    column :transactions do |user|
      s = user.transactions.count.to_s
      unless user.transactions.blank?
        s += " " + link_to("See all", admin_transactions_path)
      end
      s.html_safe
    end
    column :notes
    default_actions
  end
end
