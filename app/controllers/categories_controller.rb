class CategoriesController < ApplicationController
  # Only administrators manage categories. The index is public so visitors can
  # browse available tags without logging in.
  before_action :require_login, except: %i[index]
  before_action :require_active_user, except: %i[index]
  before_action :require_admin, except: %i[index]
  before_action :set_category, only: %i[show edit update destroy]

  # Lists all categories alphabetically for discovery.
  def index
    @categories = Category.order(:name)
  end

  # Displays the details for a single category.
  def show; end

  # Presents a blank form for creating a new category.
  def new
    @category = Category.new
  end

  # Persists a category and redisplays the form when validations fail.
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: "Category created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Presents the edit form with the existing category data.
  def edit; end

  # Applies updates and keeps the admin on the form if validation errors occur.
  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Removes the category and returns to the listing screen.
  def destroy
    @category.destroy
    redirect_to categories_path, notice: "Category removed successfully."
  end

  private

  # Loads the requested category for actions that operate on an existing record.
  def set_category
    @category = Category.find(params[:id])
  end

  # Limits mutations to the single attribute the UI collects.
  def category_params
    params.require(:category).permit(:name)
  end
end
