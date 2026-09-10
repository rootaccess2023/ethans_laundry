class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # ActiveAdmin's default filter sidebar needs Ransack's searchable
  # attributes/associations allowlisted per model. Default to everything
  # except devise's sensitive auth columns; override per-model to narrow
  # further for anything more sensitive.
  RANSACK_BLOCKED_ATTRIBUTES = %w[encrypted_password reset_password_token reset_password_sent_at].freeze

  def self.ransackable_attributes(_auth_object = nil)
    column_names - RANSACK_BLOCKED_ATTRIBUTES
  end

  def self.ransackable_associations(_auth_object = nil)
    reflect_on_all_associations.map { |a| a.name.to_s }
  end
end
