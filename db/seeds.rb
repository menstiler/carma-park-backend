
User.destroy_all
Space.destroy_all

mendel = User.create(name: "Mendel", username: '1', password: '1')
tom = User.create(name: "Tom", username: '2', password: '2')
fred = User.create(name: "Fred", username: '3', password: '3')

locations = [
  ["-73.939592", "40.66467", "760 Montgomery Street, New York", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.66467,-73.939592&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"],
  ["-74.012919", "40.707801", "12 Rector Street, Manhattan, New York", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.707801,-74.012919&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"],
  ["-73.944715", "40.666714", "1334 Carroll Street, New York", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.666714,-73.944715&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"],
  ["-73.935565", "40.667249", "1756 President Street, New York", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.667249,-73.935565&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"],
  ["-73.946215", "40.66925", "670 Eastern Parkway, New York", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.66925,-73.946215&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"],
  ["-73.93891", "40.664616", "780 Montgomery Street, New York", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.664616,-73.93891&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"],
  ["-74.009126", "40.709294", "56 Liberty Place, Manhattan, New York", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.709294,-74.009126&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"],
  ["-117.738165", "33.602281", "5 Blackbird Lane, Aliso Viejo, 92656", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=33.602281,-117.738165&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"]
]

location2 = [
  ["-74.3688169473684", "40.5923936184211", "45 Rolling Brook Dr, Edison, NJ", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=42.189531,-72.783316&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"],
  ["-74.01159653282929", "40.71094497870827", "1 World Trade Center, New York", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.71094497870827,-74.01159653282929&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"],
  ["-73.998145", "40.727934", "10 Water Street, Manhattan, New York", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.727934,-73.998145&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"],
  ["-74.011616", "40.707717", "20 Wall Street, Manhattan, New York", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.707717,-74.011616&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"],
  ["-73.98965799999999", "40.741103499999994", "Flatiron Building, New York", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.741103499999994,-73.98965799999999&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"],
  ["-74.010189", "40.705068", "56 Beaver Street, Manhattan, New York", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.705068,-74.010189&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"],
  ["-74.005097", "40.715815", "12 Thomas Street, Manhattan, New York", "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.715815,-74.005097&fov=90&heading=200&pitch=5&key=AIzaSyBXlqgVsRRwt4C-m-rMXsf4mhWELa7aqwk"]
]

locations.each do |location|
  space = Space.create(longitude: location[0],latitude: location[1], address: location[2], claimed: false, owner: mendel.id, claimer: nil, image: location[3])
  UserSpace.create(space_id: space.id, user_id: space.owner, space: space, status: "created")
end

location2.each do |location|
  space = Space.create(longitude: location[0],latitude: location[1], address: location[2], claimed: false, owner: tom.id, claimer: nil, image: location[3])
  UserSpace.create(space_id: space.id, user_id: space.owner, space: space, status: "created")
end
# UserSpace.create(user_id: User.find(1).id, space_id: Space.find(1).id)
# UserSpace.create(user_id: User.find(2).id, space_id: Space.find(2).id)
# UserSpace.create(user_id: User.find(3).id, space_id: Space.find(3).id)
