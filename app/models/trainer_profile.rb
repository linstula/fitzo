class TrainerProfile < ActiveRecord::Base
  include PgSearch

  belongs_to :user

  has_many :locations, 
    through: :trainer_locations
  has_many :trainer_locations, 
    dependent: :destroy

  has_many :services,
    dependent: :destroy

  has_many :specialties, 
    through: :trainer_specialties
  has_many :trainer_specialties,
    dependent: :destroy

  has_many :recommendations,
    dependent: :destroy

  validates_presence_of :user_id

  accepts_nested_attributes_for :services, allow_destroy: true

  attr_accessible :services_attributes

  pg_search_scope :specialties_search,
    using: {tsearch: {dictionary: "english"}},
    associated_against: {user: :username, specialties: :title}
    
    

  def self.search_by_specialties(query)
    if query.present?
      specialties_search(query)
    else
      scoped
    end
  end

  def owner?(current_user)
    current_user == user
  end

  def current_specialty_ids
    specialties.pluck(:id).map(&:to_s)
  end

  def add_specialties(specialty_ids)
    new_ids =  specialty_ids - current_specialty_ids

    new_ids.each do |new_id|
      trainer_specialties.create(specialty_id: new_id)
    end
  end

  def remove_specialties(specialty_ids)
    ids_to_remove =  current_specialty_ids - specialty_ids

    trainer_specialties.where(specialty_id: ids_to_remove).destroy_all
  end

  def update_specialties(specialty_ids)
    add_specialties(specialty_ids)
    remove_specialties(specialty_ids)
  end
end
