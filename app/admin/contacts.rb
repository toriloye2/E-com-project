ActiveAdmin.register Contact do

  actions :index, :edit, :update
  permit_params :title, :content
  
end
