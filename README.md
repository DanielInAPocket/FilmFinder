# FilmFinder
FilmFinder is a small project aimed to make it easier to look for a movies to watch and keep track of them.

# Installation
Project uses helper tools such as SwiftLint and SwiftGen. While they are not really necessary to run the project, Xcode will give you a warning if you don't have those tools. But there is a helper script that will help you install those tools. From projects root directory run 
```bash
./Scripts/install_all_tools.sh
```

NOTE: Helper scripts use Homebrew to install necessary tools, so be sure to have that installed too.

From now on project should be "Plug and Play" - just run it as a regular iOS project.

# Important
Project uses TMDB API (The movie data base). According to their own [forums](https://www.themoviedb.org/talk/626c3b5a2ac499004fdf2620), there is a DNS issue when using Claudflare DNS servers. Switching DNS server to anything other then Cloudflare (for example, Googles `8.8.8.8`) fixes the issue.
