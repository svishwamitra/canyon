class Baseapp < ActiveRecord::Migration
  def self.up
    
    # Create Settings Table
    create_table :settings, :force => true do |t|
      t.string :label
      t.string :identifier
      t.text   :description
      t.string :field_type, :default => 'string'
      t.text   :value

      t.timestamps
    end
    
    # Create Users Table
    create_table :users do |t|
      t.string :login, :limit => 40
      t.string :identity_url      
      t.string :name, :limit => 100, :default => '', :null => true
      t.string :email, :limit => 100
      t.string :crypted_password, :limit => 40
      t.string :salt, :limit => 40
      t.string :remember_token, :limit => 40
      t.string :activation_code, :limit => 40
      t.string :state, :null => :false, :default => 'passive'      
      t.datetime :remember_token_expires_at
      t.string :password_reset_code, :default => nil
      t.datetime :activated_at
      t.datetime :deleted_at
      t.integer :role_id
      
      t.timestamps
    end
    
    add_index :users, :login, :unique => true
    
    # Create Profile Table
    create_table :profiles do |t|
      t.references :user

      t.string :real_name
      t.string :location
      t.string :website
      
      t.timestamps
    end    
    
    create_table :roles do |t|
      t.column :name, :string
    end
     
    
  end

  def self.down
    # Drop all BaseApp
    drop_table :settings
    drop_table :users
    drop_table :profiles
    drop_table :roles
  end
end
