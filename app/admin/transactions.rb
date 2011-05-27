ActiveAdmin.register Transaction do
  index do
    column :id
    column :status
    column :user
    column :params do |t|
      truncate(t.notification)
    end
    column :created_at
    default_actions
  end  
end
