require "sequel"
require "json"
require_relative "./dropbox.rb"

DB = Sequel.connect(ENV["HEROKU_POSTGRESQL_OLIVE_URL"] || "sqlite://database.db")
#DB = Sequel.sqlite

DB.create_table? :sightings do 
    primary_key :id
    String :title
    String :description
    String :name
    String :contact_info
    Float :longitude
    Float :latitude
    Date :date
    Date :record_date
    foreign_key :images
    foreign_key :comments
end

DB.create_table? :images do
    primary_key :id
    String :extname
    foreign_key :sighting_id
end

DB.create_table? :comments do
    primary_key :id
    String :name
    String :text
    foreign_key :sighting_id
end

class Sighting < Sequel::Model; 
    one_to_many :images
    one_to_many :comments
    plugin :json_serializer
end

class Image < Sequel::Model
    many_to_one :sighting
    plugin :json_serializer
end

class Comment < Sequel::Model
    many_to_one :sighting
    plugin :json_serializer
end


Sighting[1].update(:description => 'According to Patterson and Gimlin, they were supposedly the only witnesses to their brief encounter with what they claimed was a Sasquatch. Their statements agree in general, but Long notes a number of inconsistencies. In an article in Argosy magazine, Ivan T. Sanderson gave the time of the encounter as 3:30 p.m., which differed from the 1:30 p.m. time in other articles and in interviews by Patterson and Gimlin. They offered somewhat different sequences in describing how they and the horses reacted upon seeing the creature. Patterson in particular increased his estimates of the creature\'s size in subsequent retellings of the encounter. In a different context, Long argues, these discrepancies would probably be considered minor, but given the extraordinary claims made by Patterson and Gimlin, any apparent disagreements in perception or memory are worth noting.

As their stories went, in the early afternoon of October 20, Patterson and Gimlin were at Bluff Creek. Both were on horseback when they "came to an overturned tree with a large root system at a turn in the creek, almost as high as a room." When they rounded it, they spotted the figure behind it nearly simultaneously, while it was "crouching beside the creek to their left." Gimlin later described himself as in a mild state of shock after first seeing the figure.

Patterson estimated he was about 25 ft (7.6 m) away from the creature at his closest. Patterson said that his horse reared upon seeing (or perhaps smelling) the figure, and he spent about twenty seconds extricating himself from the saddle and getting his camera from a saddlebag before he could run toward the figure while operating his camera. He yelled "Cover me" to Gimlin, who thereupon crossed the creek on horseback, rode forward a while, and, rifle in hand, dismounted (presumably because his horse might have panicked if the creature charged, spoiling his shot).

The figure had walked away from them to a distance of about 120 ft (36.5 m) before Patterson began to run after it. The resulting film (about 53 seconds long) is initially quite shaky until Patterson gets about 80 ft (24.4 m) from the figure. At that point, the figure glanced over its right shoulder at the men and Patterson fell to his knees; on Krantz\'s map this corresponds to frame 264. To researcher John Green, Patterson would later characterize the creature\'s expression as one of "contempt and disgust...you know how it is when the umpire tells you \'one more word and you\'re out of the game.\' That\'s the way it felt."

At this point the steady middle portion of the film begins, containing the famous frame 352 (see accompanying photo above). Patterson said "it turned a total of I think three times," the first time therefore being before the filming began. Shortly after glancing over its shoulder, the creature walks behind a grove of trees, reappears for a while after Patterson moved ten feet to a better vantage point, then fades into the trees again and is lost to view as the reel of film ran out. Gimlin remounted and followed it on horseback, keeping his distance, until it disappeared around a bend in the road three hundred yards away. Patterson called him back at that point, feeling vulnerable on foot without a rifle, because he feared the creature\'s mate might approach.

Next, Gimlin rounded up Patterson\'s horses, which had run off before the filming began, and "the men then tracked it for three miles (5 km), but lost it in the heavy undergrowth." They returned to the initial site, measured the creature\'s stride, made two plaster casts (of the best-quality right and left prints), and covered the other prints to protect them. The entire encounter had lasted less than two minutes.

A few hours after the encounter, Patterson telephoned Donald Abbott, whom Krantz described as "the only scientist of any stature to have demonstrated any serious interest in the [Bigfoot] subject," hoping he would help them search for the creature. Abbott declined, and Krantz argued this call the same day of the encounter is evidence against a hoax, at least on Patterson\'s part.

Forestry worker Lyle Laverty happened upon the site a day later and photographed the tracks. Taxidermist and outdoorsman Robert Titmus went to the site with his brother-in-law nine days later. Titmus made casts of the creature\'s prints and, as best he could, plotted Patterson\'s and the creature\'s movements on a map.

Patterson initially estimated its height at six and one-half to seven feet, and later raised his estimate to about seven and one-half feet. (Some later analysts, anthropologist Grover Krantz among them, have suggested Patterson\'s later estimate was about a foot too tall.) The film shows what Patterson and Gimlin claimed was a large, hairy bipedal apelike figure with short black hair covering most of its body, including the figure\'s prominent breasts. The figure depicted in the Patterson–Gimlin film generally matches the descriptions of Bigfoot offered by others who claim to have seen the creatures.')


Sighting[2].update(:description => "I was filming two of my friends, Dave and Joe, fishing when a sasquatch snuck up on us. The next thing I knew, the big foot had ripped Dave's heart out and fed it to him! Next he just ripped his arm off. Then he threw Dave's arm at Joe, with such a great force that it knocked him into the water, and killed him!

I am just amazed he left me alone.

I was also able to film the whole event, and even uploaded it to youtube - https://www.youtube.com/watch?v=XleygjgB-uA")