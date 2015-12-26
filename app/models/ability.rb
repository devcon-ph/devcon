class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.role? :admin
      can :manage, :all
    else
      can :read, Event
      can :read, Category
      can :read, Tag

      can :read, Article do |article|
        article.draft == false
      end

      # Commented out because we are using
      # Disqus for comments
      #
      # can :create, Comment
      # can :update, Comment do |comment|
      #   comment.try(:user) == user
      # end
      # can :destroy, Comment do |comment|
      #   comment.try(:user) == user
      # end

      if user.role?(:author)
        can :read, Article
        can :create, Article
        can :update, Article do |article|
          article.try(:author) == user
        end
        can :destroy, Article do |article|
          article.try(:author) == user
        end

        can :create, Category
        can :update, Category

        can :create, Tag
        can :update, Tag

        # Always performed
        can :access, :ckeditor   # needed to access Ckeditor filebrowser

        # Performed checks for actions:
        can [:read, :create, :destroy], Ckeditor::Picture
        can [:read, :create, :destroy], Ckeditor::AttachmentFile
      end
    end
  end
end
