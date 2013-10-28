class CommentsController < ApplicationController
  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    unless params[:comment][:recipe_id].to_i == Recipe.current_recipe.id
      redirect_to content_path, flash: {error: "That is not this month's recipe"}
      return
    end
    unless params[:comment][:user_id].to_i == current_user.id
      redirect_to content_path, flash: {error: "You can't do that."}
      return
    end

    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to content_path, notice: 'Successfully commentted.' }
      else
        format.html { redirect_to content_path, flash: {error: 'Comment could not be created.'}}
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to content_path, notice: 'Comment was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to content_path, notice: "Successfully deleted comment."}
    end
  end
end
