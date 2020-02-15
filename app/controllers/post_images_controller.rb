class PostImagesController < ApplicationController

	# 画像の投稿画面を表示する
	def new
		@post_image = PostImage.new
	end

	# 投稿画像を保存する
	def create
		@post_image = PostImage.new(post_image_params)
		@post_image.user_id = current_user.id
		if @post_image.save
			redirect_to post_images_path
		else
			render :new
		end
	end

	# 投稿画像のリストを表示する画面を作る
	def index
		@post_images = PostImage.page(params[:page]).reverse_order
	end

	# 投稿画像の詳細を表示する画面を作る
	def show
		@post_image = PostImage.find(params[:id])
		@post_commet = PostComment.new
	end

	def destroy
		@post_image = PostImage.find(params[:id])
		@post_image.destroy
		redirect_to post_images_path
	end

	# 投稿データのストロングパラメータ
	private
		def post_image_params
			params.require(:post_image).permit(:shop_name, :image, :caption)
		end
	end