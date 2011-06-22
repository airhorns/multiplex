ActiveAdmin.register Invite do
  index do
    column :id
    column :code
    column :used
    column :user do |invite|
      if invite.user.present?
        link_to invite.user.email, admin_user_path(invite.user)
      else
        "unused"
      end
    end
    column :notes
    column :created_at
    column :updated_at
    default_actions
  end
end
