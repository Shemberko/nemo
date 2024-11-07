# frozen_string_literal: true

class PostPolicy <ApplicationPolicy
  def index?
    true
  end

  def show?
    user&.present?
  end

  def edit?
    user.present? && user == record.user
  end
end
