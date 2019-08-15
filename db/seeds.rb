
User.create(name: "Mendel", username: '1')
User.create(name: "Tom", username: '2')
User.create(name: "Fred", username: '3')

locations = [
  ["-74.0693417333333", "40.7259088", "780 Montgomery St, Jersey City, NJ 07306, USA"],
  ["-73.9389079617296", "40.6645073", "780 Montgomery St, Brooklyn, NY 11213, USA"],
  ["-74.01407030000001", "40.7052529", "11 Broadway, New York, NY 10004, USA"],
  ["-74.0138074", "40.7054375", "25 Broadway, New York, NY, USA"],
  ["-74.01382800000002", "40.7053417", "15 Broadway Manhattan New York New York County New York United States 10004"],
  ["-74.01396260000001", "40.7050088", "20 Broadway, New York, NY 10004, USA"],
  ["-73.9539965", "40.7069093", "11 Broadway, Brooklyn, NY 11249, USA"],
  ["-74.3688169473684", "40.5923936184211", "45 Rolling Brook Dr, Edison, NJ 08820, USA"]
]

locations.each do |location|
  Space.create(longitude: location[0],latitude: location[1], address: location[2] ,claimed: false, owner: User.find(1).id, claimer: nil, available: true)
end


UserSpace.create(user_id: User.find(1).id, space_id: Space.find(1).id)
UserSpace.create(user_id: User.find(2).id, space_id: Space.find(2).id)
UserSpace.create(user_id: User.find(3).id, space_id: Space.find(3).id)
