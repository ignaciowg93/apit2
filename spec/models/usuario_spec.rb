require 'rails_helper'

RSpec.describe Usuario, type: :model do


  it { should validate_presence_of(:usuario) }
  it { should validate_presence_of(:nombre) }
  it {should validate_uniqueness_of(:id)} 
 
end
