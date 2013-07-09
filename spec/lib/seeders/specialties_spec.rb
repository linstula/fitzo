require 'spec_helper'

describe Seeders::Specialties do

  let(:seeder) { Seeders::Specialties }

  it 'seeds specialties' do
    specialties_count = Specialty.count
    seeder.seed
    expect(Specialty.count).to_not eq(specialties_count)
  end

  it 'can be run multiple times without duplication' do
    seeder.seed
    specialties_count = Specialty.count
    seeder.seed
    expect(Specialty.count).to eq(specialties_count)
  end
end
