<div id="top"></div>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/RoyNkem/Braze_2.0">
    <img src="https://user-images.githubusercontent.com/95645767/197086805-88b33a07-54e6-42ec-8ea8-2782de4db61d.jpg" width="80" height="80" />
  </a>

  <h3 align="center">Braze 2.0</h3>

  <p align="center">
    A cryptocurrency tracker with User Portfolio features to buy and swap coin.
    <br />
    <a href="https://youtu.be/L1K2dLpag9Q">View Demo</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#features">Features</a></li>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#screenshots">Screenshots</a></li>
    <li><a href="#api-reference">API Reference</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

A Crypto Currency Tracker created using `SwiftUI` with `MVVM` architecture.
Braze tracks live prices of crypto coins and can create mock portfolio.

Using `Combine` framework with `Subscribers/Publishers` for efficient Data loading and
`CoreData` for Local Data Persistance.

#### Show some :heart: and star the repo to support the project.

<p align="right">(<a href="#top">back to top</a>)</p>



### Built With 

<a href="https://developer.apple.com/xcode/" target="_blank"> <img src="https://img.shields.io/badge/Xcode-1882e8?style=for-the-badge&logo=Xcode&logoColor=white" alt="Xcode"/> </a> 
<a href="https://www.coingecko.com/en/api" target="_blank"> <img src="https://img.shields.io/badge/coingecko api-AAFF00?style=for-the-badge&logo=Bitcoin&logoColor=white" alt="coingecko"/> </a>
<a href="https://stackoverflow.com" target="_blank"> <img src="https://img.shields.io/badge/stackoverflow-f58023?style=for-the-badge&logo=stackoverflow&logoColor=white" alt="stackoverflow"/> </a>
<a href="https://github.com/" target="_blank"> <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/> 
<a href="https://youtube.com" target="_blank"> <img src="https://img.shields.io/badge/youtube-ff0000?style=for-the-badge&logo=youtube&logoColor=white" alt="youtube"/> </a>
<a href="https://developer.apple.com/swift/" target="_blank"> <img src="https://img.shields.io/badge/Swift-f15139?style=for-the-badge&logo=Swift&logoColor=white" alt="Swift"/> </a>

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

### Features 
- [x] CoreData
- [x] Combine Framework 
- [x] Light/dark mode 
- [x] Live prices
- [x] User Portfolio 
- [ ] iPad support
- [x] MVVM architecture
- [x] Search Features
- [x] Details of Coins 
- [ ] Coin Price History

### Prerequisites

Before you start running the "Braze" iOS app, ensure you have the following prerequisites:

1. **Xcode:** Install Xcode, which is the development environment for building iOS apps. You can download it from the [Mac App Store](https://apps.apple.com/us/app/xcode/id497799835).

2. **Git:** Make sure you have Git installed on your system for version control. You can download and install Git from the [Git website](https://git-scm.com/).

3. **GitHub Account:** You'll need a GitHub account to clone the repository and collaborate with the project. You can sign up for free on the [GitHub website](https://github.com/).

4. **iOS Device or Simulator:** To run the app, you can either use a physical iOS device connected to your computer or an iOS simulator provided by Xcode.


### Installation

_No API key or npm packages are required for the Braze app. Below are the steps to quickly get started._

1. Clone the repository:
   
   ```sh
   git clone https://github.com/RoyNkem/Braze_2.0.git

2. Navigate to the cloned directory:

   ```sh
   cd Braze_2.0
   ```
   
3. Run the App
   Launch the Braze app using a development server:
   ```sh
   open Braze_2.0.xcodeproj
   ```

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- SCREENSHOTS -->
## ScreenShots

<p>
<img src="https://user-images.githubusercontent.com/95645767/197089523-c92d7ac3-32ab-4c67-8386-d1cd2943fa46.png" alt="Home View Dark" width = "220" />
<img src="https://user-images.githubusercontent.com/95645767/197089527-002480a4-949b-483e-93e4-a16f34649309.png" alt="Home View Dark" width = "220.5"/>
<img src="https://user-images.githubusercontent.com/95645767/197089745-f7dcfcd3-1025-44f7-9a38-68a7d5c1887a.png" alt="Portfolio View Light" width = "220"/>
<img src="https://user-images.githubusercontent.com/95645767/197089759-b643e3e6-8213-4b6b-ac1f-291ee44744a5.png" alt="Portfolio View Dark" width = "220.5"/>
<img src="https://user-images.githubusercontent.com/95645767/197090055-c04ff549-93fd-41a0-9277-4d801aa50289.png" alt="Search View Light" width = "220"/>
<img src="https://user-images.githubusercontent.com/95645767/197090065-d6ff88b7-d930-4927-88b0-b02a4439eb4e.png" alt="Search View Dark" width = "220.5"/>

<img src="https://user-images.githubusercontent.com/95645767/197090120-160bebde-d7f0-439e-b49d-bc8247e03325.png" alt="Search View Light" width = "220"/>
<img src="https://user-images.githubusercontent.com/95645767/197090129-c436cfd9-e38f-403f-8ac6-b84bd26ffd81.png" alt="Search View Light" width = "220"/>

<img src="https://user-images.githubusercontent.com/95645767/197090076-78753467-ce53-47a1-beb1-d7ce2f1c2592.png" alt="Search View Light" width = "220"/>
 </p>

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- API REFERENCE -->
## API Reference

#### Get all coins

```http
  GET https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `vs_currency` | `string` | **Required**. currency format |
| `order` | `string` | valid values: market_cap_desc, gecko_desc, gecko_asc, market_cap_asc, market_cap_desc, volume_asc, volume_desc, id_asc, id_desc |
| `per_page` | `integer` |  Total results per page |
| `page` | `integer` | Page through results |
| `sparkline` | `boolean` | Include sparkline 7 days data (eg. true, false)
| `price_change_percentage` | `string` | Include price change percentage in 1h, 24h, 7d, 14d, 30d, 200d, 1y |


<p align="right">(<a href="#top">back to top</a>)</p>


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

[![Twitter](https://img.shields.io/twitter/follow/TheRoyAiyetin?style=social)](https://twitter.com/TheRoyAiyetin)
[![LinkedIn](https://img.shields.io/badge/-LinkedIn-blue?style=flat-square&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/roy-aiyetin-97867718a)

Project Link: [Braze_2.0](https://github.com/RoyNkem/Braze_2.0)

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/RoyNkem/Braze_2.0.svg?style=for-the-badge
[contributors-url]: https://github.com/RoyNkem/Braze_2.0/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/RoyNkem/Braze_2.0.svg?style=for-the-badge
[forks-url]: https://github.com/RoyNkem/Braze_2.0/network/members
[stars-shield]: https://img.shields.io/github/stars/RoyNkem/Braze_2.0.svg?style=for-the-badge
[stars-url]: https://github.com/RoyNkem/Braze_2.0/stargazers
[issues-shield]: https://img.shields.io/github/issues/RoyNkem/Braze_2.0.svg?style=for-the-badge
[issues-url]: https://github.com/RoyNkem/Braze_2.0/issues
[license-shield]: https://img.shields.io/github/license/RoyNkem/Braze_2.0.svg?style=for-the-badge
[license-url]: https://github.com/RoyNkem/Braze_2.0/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/roy-aiyetin-97867718a/
[product-screenshot]: images/screenshot.png
