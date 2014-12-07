ActiveAdmin.register Person do
  permit_params :name, :email, :state, :active, :partner_id

  filter :name
  filter :state, collection: Person::STATE
  filter :email
  filter :updated_at

  index do
    selectable_column
    column :name
    column :email
    column :partner do |person|
      person.partner.try(:name)
    end
    column :state
    column :active
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :partner
      row :state
      row :active
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Person Details" do
      f.input :name
      f.input :email
      f.input :partner, collection: Person.possible_partners(person).to_a
      f.input :state, collection: Person::STATE
      f.input :active
    end
    f.actions
  end

  batch_action :set_validated do |selection|
    Person.where(id: selection).update_all(state: 'validated')
    redirect_to :action => :index
  end

  batch_action :deactivate do |selection|
    Person.where(id: selection).update_all(active: false)
    redirect_to :action => :index
  end

  batch_action :activate do |selection|
    Person.where(id: selection).update_all(active: true)
    redirect_to :action => :index
  end

  collection_action :send_validations, method: :post do
    Person.active.each do |person|
      ValidationMailer.validate_mail(person).deliver
    end
    redirect_to admin_people_path, notice: 'Sent validations'
  end

  collection_action :assign_partners, method: :post do
    secret_santas = Person.assignable
    return redirect_to(admin_people_path, notice: 'Not enough people validated.') if secret_santas.count < 2
    assignments = Person.assign_partners(secret_santas)
    return redirect_to(admin_people_path, notice: 'No combination found, maybe none possible?') if assignments.empty?
    redirect_to admin_people_path, notice: 'Partners assigned'
  end

  collection_action :send_notifications, method: :post do
    Person.notifiable.each do |person|
      NotificationMailer.your_partner(person).deliver
    end
    redirect_to admin_people_path, notice: 'Sent notifications'
  end

  member_action :send_validation, method: :post do
    person = Person.find(params[:id])
    ValidationMailer.validate_mail(person).deliver
    redirect_to admin_people_path, notice: 'Sent validation'
  end

  member_action :send_notification, method: :post do
    person = Person.notifiable.where(id: params[:id]).try(:first)
    NotificationMailer.your_partner(person).deliver if person
    redirect_to admin_people_path, notice: 'Sent notification'
  end

  action_item(:send_validations, only: :index) do
    link_to 'Validate People', send_validations_admin_people_path, method: :post
  end

  action_item(:send_validation, only: [:show, :edit]) do
    link_to 'Validate', send_validation_admin_person_path(person), method: :post
  end

  action_item(:assign_partners, only: :index) do
    link_to 'Assign', assign_partners_admin_people_path, method: :post
  end

  action_item(:send_notifications, only: :index) do
    link_to 'Notify People', send_notifications_admin_people_path, method: :post
  end

  action_item(:send_notification, only: [:show, :edit]) do
    link_to 'Notify', send_notification_admin_person_path(person), method: :post
  end

end
