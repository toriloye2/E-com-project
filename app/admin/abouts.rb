ActiveAdmin.register About do

  actions :index, :edit, :update
  permit_params :title, :content
  
end
