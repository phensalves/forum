class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    post = Post.find(params[:post_id])
    @comments = post.comments.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  def show
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])

    respond_to do |format|
      format.html
      format.json {render json: @comment}
    end
  end

  def new
    post = Post.find(params[:post_id])
    @comment = post.comments.build

    respond_to do |format|
      format.html
      format.json { render json: @comment }
    end
  end

  def edit
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])
  end

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.create(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.post, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: [@comment.post, @comment] }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    post = Post.find(params[:post_id])
    @comment = post.comments.create(comment_params)

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.post, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: [@comment.post, @comment] }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end
    def comment_params
      params.require(:comment).permit(:author, :body, :post_id)
    end
end
