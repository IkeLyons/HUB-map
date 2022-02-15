import pandas as pd
from geopy.extra.rate_limiter import RateLimiter
from geopy.geocoders import Nominatim
df = pd.read_excel('ngo-paris-master-list.xlsx')

df = df.dropna(subset=['location'])
print(df['location'])
geolocator = Nominatim(user_agent="Paris-Hub-Map")
geocode = RateLimiter(geolocator.geocode, min_delay_seconds=.25)

def try_geocode(addy):
    try:
        print("geocoded", addy)
        return geolocator.geocode(addy)
    except:
        print("could not geocode", addy)
        return 


df['geoloc'] = df['location'].apply(lambda x: try_geocode(x))
print(df['geoloc'])
df['point'] = df['geoloc'].apply(lambda loc: tuple(loc.point) if loc else None)
df[['latitude', 'longitude', 'altitude']] = pd.DataFrame(df['point'].tolist(), index=df.index)

print(df['latitude'])

df.to_csv('geocoded-list.csv')