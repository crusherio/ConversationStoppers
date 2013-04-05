class RootController < UIViewController
  stylesheet :root

  layout :root do
    @label = subview(UILabel, :label)
    @long_button = subview(UIButton.rounded_rect, :long_button)
    @gear = subview(UIButton.rounded_rect, :settings_button)
    @ad = subview(ADBannerView, :ads)
  end  

  def viewDidLoad
    super

    # Title for this view
    self.title = "Conversation Stoppers"
    # Stoppers engine
    @stoppers = Stoppers.new

    # all button code
    self.initialize_buttons

    # make navigation use our special button
    @nav_bar_button = UIBarButtonItem.alloc.initWithCustomView(@gear)
    self.navigationItem.rightBarButtonItem = @nav_bar_button

    # Handle ads
    @ad.delegate = AdDelegate

  end

  def initialize_buttons
    # Use custom button for navigation button and events for stopper button
    @gear.on(:touch) do
      @settings = SettingsController.alloc.init 
      self.navigationController << @settings
    end

    # On touch pull the next line
    @long_button.on(:touch) do 
      @label.text = @stoppers.next_line
      @label.fit_to_size(40)
    end
  end

end
