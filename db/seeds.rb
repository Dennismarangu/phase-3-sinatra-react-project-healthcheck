require 'faker'

def generate_hospital_data
  hospitals = []

  10.times do
    hospitals << {
      name: Faker::Company.name,
      location: Faker::Address.city
    }
  end

  hospitals
end

puts "🌱 Seeding hospitals..."

hospitals = generate_hospital_data
puts hospitals

# Seed your database with the generated hospital data here

puts "✅ Done seeding!"
