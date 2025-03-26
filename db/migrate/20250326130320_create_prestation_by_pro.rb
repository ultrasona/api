class CreatePrestationByPro < ActiveRecord::Migration[7.1]
  def change
    create_join_table(:prestation, :pro, table_name: 'prestation_by_pro')
  end
end
