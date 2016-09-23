 describe Selenium do


@data = YAML.load(File.open('details.yml'))

  before :all do
    @driver = Selenium::WebDriver.for :chrome
    @name = 'Space Invaders'
    @song_name = 'a song name'
    @artist = 'Alfie Thornton'
    @album = 'Alfies Sick beats'
    @genre = "funk\n"
    @publisher = 'Alfie Game Studios'
    @releaseDate = "21/03/1965"
    @ageRating = "15\n"
    @username = 'test1'
    @email =  'test1@test.com'#@data['login_details'][0]['email']
    @password = 'test1'#@data['login_details'][0]['password']

  end



  it "allows a user to register with valid details" do
    register
    expect(@driver.current_url).to eq 'http://localhost:3000/sessions/new'
  end

  it "allows a user to login with valid details" do
    login
    expect(@driver.current_url).to eq 'http://localhost:3000/games'
  end



  it "denies a user to register with invalid details" do
    @driver.navigate.to url('/users/new')
    username = @driver.find_element(name: 'username')
    username.send_keys ''
    email = @driver.find_element(name: 'email')
    email.send_keys ''
    password = @driver.find_element(name: 'password')
    password.send_keys ''
    submitBtn = @driver.find_element(css: 'body > form > input[type="submit"]').click
    expect(@driver.current_url).to eq  url('/users/new')
  end

  it "denies a user logging with invalid details" do
    @driver.navigate.to url('/sessions/new') if @driver.current_url != url('/sessions/new')
    email = @driver.find_element(name: 'email')
    email.send_keys ''
    password = @driver.find_element(name: 'password')
    password.send_keys ''
    submitBtn = @driver.find_element(css: 'body > form > input[type="submit"]').click
    expect(@driver.current_url).to eq url('/sessions/new')
  end

# all of the games tests ££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££

  it "should add a new game with valid inputs" do
    login
    @driver.navigate.to url('/games/new')
    formCheckName = @driver.find_element(name: 'name')
    formCheckName.send_keys @name
    formCheckPublisher = @driver.find_element(name: 'publisher')
    formCheckPublisher.send_keys @publisher
    formCheckRdate = @driver.find_element(name: 'releaseDate')
    formCheckRdate.send_keys @releaseDate
    formCheckAgeRating = @driver.find_element(name: 'ageRating')
    formCheckAgeRating.send_keys @ageRating
    expect(@driver.current_url).to eq url('/games')
    expect(@driver.page_source).to include @name
  end

  it 'should not allow null fields to be succesfully added'  do
    login
    @driver.navigate.to url('/games/new')
    formCheckName = @driver.find_element(name: 'name')
    formCheckName.send_keys("\n")
    expect(@driver.current_url).to eq url('/games/new')
  end

  it 'should display all of the information of a given record when you click on a game' do
    login
    @driver.navigate.to url('/games')
    clickLink = @driver.find_element(link: "Space Invaders").click
    expect(@driver.page_source).to include @name
    expect(@driver.page_source).to include @releaseDate
    expect(@driver.page_source).to include @ageRating
  end

  it 'only allows a valid date to be entered in the date field' do
    login
    @driver.navigate.to url('/games/new')
    formCheckName = @driver.find_element(name: 'name')
    formCheckName.send_keys @name
    formCheckPublisher = @driver.find_element(name: 'publisher')
    formCheckPublisher.send_keys @publisher
    formCheckRdate = @driver.find_element(name: 'releaseDate')
    formCheckRdate.send_keys('this is a date field')
    formCheckAgeRating = @driver.find_element(name: 'ageRating')
    formCheckAgeRating.send_keys @ageRating
    expect(@driver.current_url).to eq url('/games/new')
  end

  it 'allows details to be edited using edit' do
    login
    @driver.navigate.to url('/games')
    clickLink = @driver.find_elements(link: "edit")
    clickLink[-1].click
    findDate = @driver.find_element(name: "releaseDate")
    findDate.send_keys("12/12/1990\n")
    expect(@driver.current_url).to eq url('/games')
  end

  it 'should be able to delete records from the database' do
    login
    @driver.navigate.to url('/games')
    clickLink = @driver.find_elements(link: @name)
    clickLink[-1].click
    clickDelete = @driver.find_element(css: 'body > form > input[type="submit"]:nth-child(2)').click
  end

  # all of the songs tests ££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££

  it "should add a new song with valid inputs" do
    login
    @driver.navigate.to url('/songs/new')
    formCheckName = @driver.find_element(name: 'song_name')
    formCheckName.send_keys @song_name
    formCheckPublisher = @driver.find_element(name: 'artist')
    formCheckPublisher.send_keys @artist
    formCheckRdate = @driver.find_element(name: 'album')
    formCheckRdate.send_keys @album
    formCheckAgeRating = @driver.find_element(name: 'genre')
    formCheckAgeRating.send_keys @genre
    expect(@driver.current_url).to eq url('/songs')
    expect(@driver.page_source).to include @name
  end


  after :each do
    logout
  end

end
