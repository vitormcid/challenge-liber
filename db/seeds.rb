people_list =
[
	[ "Justin"   ,"Timberlake","79877842068", "02/12/2005", "justin@email.com"  ],
	[ "Angelina" ,"Jolie"     ,"17568397009", "31/05/1977", "angelina@email.com"],
	[ "Beyonce"  ," "         ,"25408438082", "07/08/1986", "beyoncé@email.com" ],
	[ "Brad"     ,"Pitt"      ,"87839967027", "16/05/1971", "brad@email.com"    ],
	[ "Tom"      ,"Cruise"    ,"36031680033", "07/02/1948", "tom@email.com"     ],
	[ "Gisele"   ," Bündchen" ,"33888115043", "26/02/1962", "gisele@email.com"  ],
	[ "Will"     ," Smith"	  ,"80050339079", "12/01/1987", "will@email.com"    ]
]

phones_list = 
[
	["79877842068" ,"011", "7987-7842" , "comercial" , true],
	["17568397009" ,"021", "1756-8397" , "particular", true],
	["25408438082" ,"045", "2540-8438" , "trabalho"  , true],
	["87839967027" ,"036", "98783-9967", "particular", true],
	["36031680033" ,"022", "3603-1680" , "comercial" , true],
	["33888115043" ,"032", "3388-8115" , "particular", true],
	["80050339079" ,"011", "98005-0339", "trabalho"  , true]

]

drivers_licenses_list =
[
	["79877842068" ,"7195601426" ,"A,B" ,"02/10/2023"],
	["17568397009" ,"6943716123" ,"A,C" ,"31/05/2022"],
	["25408438082" ,"1180791711" ,"B"   ,"07/08/2024"],
	["87839967027" ,"4022223573" ,"E"   ,"16/05/2023"],
	["36031680033" ,"4792176902" ,"D"	,"07/02/2023"],
	["33888115043" ,"1910131222" ,"A,B" ,"26/02/2023"],
	["80050339079" ,"6892136432" ,"A"   ,"12/10/2019"]
]

automobiles_list = 
[
	["CB 300"        ,"vermelho", "motorcycle"    , "AHD-5454", 99.99 , "2019"],
	["HB 20"  	     ,"preto"   , "car"   , "FMR-6345", 139.99, "2018"],
	["Agrale 6500"   ,"prata"   , "vuc"     , "RGH-4245", 199.99, "2017"],
	["Millennium III","azul"    , "bus"  , "BTF-5278", 279.99, "2019"],
	["Atego 2425"    ,"branco"  , "truck", "BYT-2354", 409.99, "2018"]
]

locations_list = 
[
	["17568397009" ,"HB 20"       ,199.98 ,"07/11/2019 10:30" , "09/11/2019 10:20", "07/11/2019 10:40", "09/11/2019 09:20"],
	["87839967027" ,"Agrale 6500" ,399.98 ,"07/11/2019 08:10" , "09/11/2019 10:20", "07/11/2019 08:00", "09/11/2019 10:20"]

]

people_list.each do |name, last_name, document, birth_date, email|
  Person.where(name: name,
  			   last_name: last_name,
  			   document: document,
  			   birth_date: birth_date,
  			   email: email).first_or_create()
end

phones_list.each do |document, ddd, number, kind, preferential|
  person = Person.where(document: document).first
  next unless person.present?

  Phone.where(people_id: person.id,
  			  ddd: ddd,
  			  number: number,
  			  kind: kind,
  			  preferential: preferential).first_or_create()
end

drivers_licenses_list.each do |document, number, modalities, validity|
  person = Person.where(document:document).first
  next unless person.present?

  drivers_license = DriversLicense.where(number:number,
  										 modalities:modalities,
  										 validiy: validity).first_or_create()

  person.update_attribute(:driver_license_id, drivers_license.id)
end

automobiles_list.each do |model, color, kind, license_plate, daily_cost, year|
  Automobile.where(model: model,
  				   color: color,
  				   kind: kind,
  				   license_plate: license_plate,
  				   daily_cost: daily_cost,
  				   year: year).first_or_create
end

locations_list.each do |document, automobile_model, value, start_date, end_date, withdrawal_date, return_date|
	person = Person.where(document: document).first
	automobile = Automobile.where(model: automobile_model).first
	next unless (person.present? && automobile.present?)

	Location.where(people_id: person.id,
				   automobile_id: automobile.id,
				   value: value,
				   start_date: start_date,
				   end_date: end_date,
				   withdrawal_date: withdrawal_date,
				   return_date: return_date).first_or_create  
end



