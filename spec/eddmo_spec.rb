 describe Selenium do

  before :all do
    @driver = Selenium::WebDriver.for :chrome
    @name = 'Space Invaders'
    @publisher = 'Alfie Game Studios'
    @releaseDate = "21/03/1965"
    @ageRating = "15\n"
  end


  it "should add a new game with valid inputs" do
    @driver.navigate.to 'http://localhost:3000/games/new'
    formCheckName = @driver.find_element(name: 'name')
    formCheckName.send_keys @name
    formCheckPublisher = @driver.find_element(name: 'publisher')
    formCheckPublisher.send_keys @publisher
    formCheckRdate = @driver.find_element(name: 'releaseDate')
    formCheckRdate.send_keys @releaseDate
    formCheckAgeRating = @driver.find_element(name: 'ageRating')
    formCheckAgeRating.send_keys @ageRating
    expect(@driver.current_url).to eq 'http://localhost:3000/games'
    expect(@driver.page_source).to include @name
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
    expect(@driver.page_source).to include @name
    expect(@driver.page_source).to include @releaseDate
    expect(@driver.page_source).to include @ageRating
  end

  it 'only allows a valid date to be entered in the date field' do
    @driver.navigate.to 'http://localhost:3000/games/new'
    formCheckName = @driver.find_element(name: 'name')
    formCheckName.send_keys @name
    formCheckPublisher = @driver.find_element(name: 'publisher')
    formCheckPublisher.send_keys @publisher
    formCheckRdate = @driver.find_element(name: 'releaseDate')
    formCheckRdate.send_keys('this is a date field')
    formCheckAgeRating = @driver.find_element(name: 'ageRating')
    formCheckAgeRating.send_keys @ageRating
    expect(@driver.current_url).to eq 'http://localhost:3000/games/new'
  end

  it 'allows details to be edited using edit' do
    @driver.navigate.to 'http://localhost:3000/games'
    clickLink = @driver.find_elements(link: "edit")
    clickLink[-1].click

  end

end
