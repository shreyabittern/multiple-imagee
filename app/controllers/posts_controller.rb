class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    #@posts = Post.all
    @posts = Post.where(created_at: 1.days.ago..Time.now)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post_attachments = @post.post_attachments.all
  end

  # GET /posts/new
  def new
  @post = Post.new
  @post_attachment = @post.post_attachments.build
end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      redirect_to root_path
    end 
  end

  # POST /posts or /posts.json
  def create
       @post = Post.new(post_params)
       @post.user_id = current_user.id

       respond_to do |format|
         if @post.save
           params[:post_attachments]['avatar'].each do |a|
              @post_attachment = @post.post_attachments.create!(:avatar => a,     :post_id => @post.id)
           end
           format.html { redirect_to @post, notice: 'Post was successfully     created.' }
         else
           format.html { render action: 'new' }
         end
       end
     end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end


  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    private
def post_params
  params.require(:post).permit(:title, post_attachments_attributes: 
  [:id, :post_id, :avatar])
end
end
