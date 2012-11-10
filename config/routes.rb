ThijsBlog::Application.routes.draw do
  scope '/admin' do
    resources :posts, controller: 'admin/posts'
  end

  get "posts/:slug", to: 'public_posts#show', as: 'post_by_slug'
  root to: 'public_posts#index'
end
