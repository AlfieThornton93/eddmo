 describe Selenium do

  before :all do
    @driver = Selenium::WebDriver.for :chrome
    @title = 'Unique Title'
    @text = 'This is some random text'
    @tags = '#tag1 #tag2'
    @username = 'alfiethornton'
  end


  it "should add a new game with valid inputs" do
     @driver.navigate.to 'http://localhost:3000/games/new'
    formCheckName = @driver.find_element(name: 'name')
    formCheckName.send_keys('Space Invaders')
    formCheckPublisher = @driver.find_element(name: 'publisher')
    formCheckPublisher.send_keys('Alfie Games')
    formCheckRdate = @driver.find_element(name: 'releaseDate')
    formCheckRdate.send_keys('21/03/1965')
    formCheckAgeRating = @driver.find_element(name: 'ageRating')
    formCheckAgeRating.send_keys("15\n")
    expect(@driver.current_url).to eq 'http://localhost:3000/games'
    expect(@driver.page_source).to include("Space Invaders")
  end

  it 'should not allow null fields to be succesfully added'  do
    @driver.navigate.to 'http://localhost:3000/games/new'
   formCheckName = @driver.find_element(name: 'name')
   formCheckName.send_keys("\n")
   expect(@driver.current_url).to eq 'http://localhost:3000/games/new'
  end

  it 'should display all of the information of a given record when you click on a game' do
    @driver.navigate.to 'http://localhost:3000/games'
    clickLink = @driver.find_element(link: "Space Invaders").click
    expect(@driver.page_source).to include("Alfie Games")
    expect(@driver.page_source).to include("21/03/1965")
    expect(@driver.page_source).to include("15")
  end

end
