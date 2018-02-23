require "twitter"
client = Twitter::REST::Client.new do |config|
 config.consumer_key = ck
 config.consumer_secret = cs
 config.access_token = at
 config.access_token_secret = ats
end
nb = 0
already_touched_tweet = []
while true
 max_attempts = 3
 num_attempts = 0
 begin
   client.search("#startup").take(50).each do |tweet|
     puts "#{tweet.user.screen_name}: #{tweet.text}"
     unless already_touched_tweet.include?(tweet)
       client.favorite(tweet)
       if nb%2 == 1
         client.update("Salut @#{tweet.user.screen_name}, tu connais The Hacking Project? C'est une formation gratuite qui t'apprends a développer des programmes ou des sites web en seulement 2 mois et demi! Va voir leur site si ca t'interesse! http://bit.ly/THP75", in_reply_to_status_id: tweet.id)
#          client.update("#{tweet.text}")
       else
         client.update("Salut! Tu aimerais rapidement avoir les bases du développement web, mais pas d’argent à dépenser ?? @the_hacking_pro est fait pour toi ! C’est :
- GRATUIT
- sur 3 MOIS
- accessible DE N’IMPORTE OÙ
Plus d’infos : http://bit.ly/THP75 ", in_reply_to_status_id: tweet.id)
       end
       already_touched_tweet << tweet
       nb += 1
     else
       p "already touched"
     end
     p nb
   end
 rescue Twitter::Error::TooManyRequests => error
   if num_attempts <= max_attempts
     # NOTE: Your process could go to sleep for up to 15 minutes but if you
     # retry any sooner, it will almost certainly fail with the same exception.
     p error
     p "I will sleep #{error.rate_limit.reset_in} time"
     sleep error.rate_limit.reset_in
     retry
   else
     raise
   end
 rescue Twitter::Error::Forbidden => error
   if num_attempts <= max_attempts
     # NOTE: Your process could go to sleep for up to 15 minutes but if you
     # retry any sooner, it will almost certainly fail with the same exception.
     p error
     p "I will sleep #{error.rate_limit.reset_in} time"
     sleep 5
     retry
   else
     raise
   end
 rescue StandardError => error
   p error
 end
ende
