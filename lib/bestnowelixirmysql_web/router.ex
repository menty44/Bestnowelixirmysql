defmodule BestnowelixirmysqlWeb.Router do
  use BestnowelixirmysqlWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BestnowelixirmysqlWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CORSPlug, origin: "*"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BestnowelixirmysqlWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", BestnowelixirmysqlWeb do
    pipe_through :api
    resources "/info", InfosController, except: [:new, :edit]
    resources "/mobile_payments", MobilepaymentsController, except: [:new, :edit]
    resources "/tills", TillController, except: [:new, :edit]
    resources "/paybill", PaybillController, except: [:new, :edit]
    resources "/keyword", KeywordController, except: [:new, :edit]
    resources "/bookmakers", BookmakerController, except: [:new, :edit]
    resources "/africastalkingtexts", AfricastalkingtextController, except: [:new, :edit]
    resources "/packages", PackageController, except: [:new, :edit]
    post "/paybill/phone/:number", PaybillController, :transactions
  end

  scope "/api", BestnowelixirmysqlWeb do
    pipe_through :api
    resources "/mobileusers", MobileuserController, except: [:new, :edit]
    post "/mobileusers/signin", MobileuserController, :signin
    post "/mobileusers/phonenumber", MobileuserController, :phone_number
    post "/mobileusers/reset/:number", MobileuserController, :reset_password
    get "/admin/report", MobileuserController, :report
    #    resources "/users", UserController, except: [:new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BestnowelixirmysqlWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
