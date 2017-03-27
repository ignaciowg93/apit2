class Usuario < ApplicationRecord

    validates_presence_of :usuario,:nombre
    validates_uniqueness_of :id
end
