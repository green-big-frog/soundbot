require 'rubygems'
require 'bundler/setup'

require 'discordrb'
# require 'pry'

email = ENV["EMAIL"] ||= raise("Please set EmailVar!")
password = ENV["PASSWORD"] ||= raise("Please set PasswordVar!")

admin = ENV["ADMIN"] ||= raise("Please set AdminVar to the ID of the Bot Owner")
# Can be gained by typing "\@user" in any discord chat

# binding.pry
bot = Discordrb::Bot.new(email, password)

bot.debug = true

bot.message(with_text: "invite") do |event|
  if event.author == admin
    event.respond("Yay! #{event.user.mention} is a good boy/girl!")
  else
    event.respond("#{event.user.mention} No! Just NO!")
    debug("#{event.user.name} with ID #{event.user.id} tried to make the bot join a channel without permission!")
  end
end

bot.message(with_text: "ping") do |event|
  event.respond "Pong, #{event.user.name}!"
end


bot.run :async

dir = File.dirname(__FILE__)

bot.game = "with cows! 💕"

@channel = bot.find_channel('bottest', 'buffalowave')
if @channel[0] == nil
  puts "Requested voice channel does not exist"
end
bot.voice_connect(@channel[0])

bot.voice.play_file("#{dir}/sounds/ready.wav")
bot.voice.speaking = false



bot.message(with_text: "awesome") do |event|
  bot.voice.play_file("#{dir}/sounds/awesome.mp3")
  bot.voice.speaking = false
end

bot.message(with_text: "aah") do |event|
  bot.voice.play_file("#{dir}/sounds/aah.mp3")
  bot.voice.speaking = false
end

bot.message(with_text: "coughs") do |event|
  bot.voice.play_file("#{dir}/sounds/coughs.mp3")
  bot.voice.speaking = false
end

bot.message(with_text: "gameover") do |event|
  bot.voice.play_file("#{dir}/sounds/gameover.mp3")
  bot.voice.speaking = false
end

bot.message(with_text: "gameover2") do |event|
  bot.voice.play_file("#{dir}/sounds/gameover2.mp3")
  bot.voice.speaking = false
end

bot.message(with_text: "muffintime") do |event|
  bot.voice.play_file("#{dir}/sounds/muffintime.mp3")
  bot.voice.speaking = false
end

bot.message(with_text: "oh my gosh") do |event|
  bot.voice.play_file("#{dir}/sounds/oh-my-gosh.mp3")
  bot.voice.speaking = false
end

bot.message(with_text: "omg") do |event|
  bot.voice.play_file("#{dir}/sounds/omg.mp3")
  bot.voice.speaking = false
end

bot.message(with_text: "thunder") do |event|
  bot.voice.play_file("#{dir}/sounds/thunder.mp3")
  bot.voice.speaking = false
end

bot.message(with_text: "wolves") do |event|
  bot.voice.play_file("#{dir}/sounds/wolves.mp3")
  bot.voice.speaking = false
end

bot.message(with_text: "wow") do |event|
  bot.voice.play_file("#{dir}/sounds/wow.mp3")
  bot.voice.speaking = false
end




bot.message(with_text: "leave") do |event|
  bot.voice.destroy
  bot.debug("bot left voice Channel #{@channel[0]}")
end

bot.message(contains: "!join") do |event|
  @findchannel = event.content.split[1]
  @findserver = event.content.split[2]
  @channel = bot.find_channel(@findchannel, @findserver)
  if @channel[0] == nil
    puts "Requested voice channel does not exist"
  end
  bot.voice.destroy
  bot.voice_connect(@channel.find { |e| e.type == 'voice' })
  bot.debug("bot joined voice Channel #{@channel[0]}")
end

bot.sync
