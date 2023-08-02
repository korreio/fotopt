# foto@pt - Fotografia em Português

"foto@pt" was a trailblazing website launched in 1999, dedicated to promoting the works of Portuguese-speaking photographers. It was one of the first social networks, allowing users to post and comment on photos. The website quickly grew in popularity, winning the "Best Cultural Website" at the JetNet Awards in 2001 and 2002. Despite its deactivation in 2003, "foto@pt" left a lasting legacy as a pioneer of social networking and online photography communities.

The brainchild of Tiago Fonseca, it was created with contributions from its users, but designed, developed and administered solely by Tiago Fonseca.

The website had two URLs throughout its life:
http://www.fotografia.em.pt/
and
http://www.fotopt.net (both deactivated)

## Table of Contents

- [Story and Context](#story-and-context)
- [Technology](#technology)
- [Popularity](#popularity)
- [Evolution](#evolution)
- [Community](#community)
- [Book](#book)
- [JetNet Awards](#jetnet-awards)
- [The End](#the-end)
- [Legacy](#legacy)
- [What I Would Have Done Differently](#what-i-would-have-done-differently)
- [Public Code](#public-code)
- [Contact](#contact)
- [Screenshots](#screenshots)

## Story and Context

In 1999, as a computer science student and photography enthusiast, I observed that the web was rather different from what it is today. Facebook was still five years away from being created, Instagram wasn't even a word yet, and social networking wasn't part of the vernacular.

My passion for photography led me to a mailing list called "Escrita com Luz" (literally "Writing with Light"). This community of about 100 people exchanged email messages about photography, sometimes sharing their images for other members to admire and comment on. However, the email-based communication had its limitations, such as the inability to see previous messages, lack of public access, and non-existence of discussion threads.

At the time, I was nearing the end of my computer science degree and working part-time as a web developer for a research group at NOVA School of Science and Technology in Lisbon, Portugal. Despite the demands, I found some spare time to contemplate on improving the mailing list's system. It didn't take long for an idea to strike: why not create a website offering similar functionalities to the mailing list?

After floating the idea to the mailing list's members and receiving positive feedback, I commenced work. Within a couple of weeks, I had a working first version.

## Technology

The technology I was using at the time was Active Server Pages (ASP), which has since become completely obsolete and is now referred to as "Classic ASP". This was before the advent of Microsoft .Net. If I had been able to foresee the future, I would have chosen PHP, a language I ended up using in most of my subsequent projects and is still alive and kicking.

The database was a simple Microsoft Access one, accessed through the ODBC interface using SQL.

Back then, "active" websites with dynamic content were still relatively rare; most websites contained only static HTML content. I wasn't expecting the project to scale significantly, so I adopted the KISS (Keep It Simple and Stupid) principle.

The site was primarily in Portuguese, with some limited English functionality. The code was written in Portuguese, excluding the ASP-specific syntax.

## Popularity

Over the next three years, the website experienced explosive growth.

I believe I can safely claim that it was one of the first:
- websites open to anyone to showcase their photographs,
- platforms that allowed others to comment on displayed photos,
- sites targeted at Portuguese-speaking photographers, both amateur and professional,
- social networks.

The term "social network" wasn't in common use back then, but in hindsight, the website had many elements that are now considered hallmarks of such platforms: a user page, user-generated content (not only photo posts but also text posts with "stories"), comments, and voting for best pictures. It also hosted forums with very active discussions on all things photography.

Being the first of its kind, the website quickly attracted anyone interested in photography and sharing their work. Keep in mind that this was an era when phones didn't have cameras, and digital cameras were still in their infancy. Thus, analog reflex cameras dominated, and people had to digitize their photos before uploading them.

The website's popularity drew many professional photographers who began sharing their work. Soon, the website was featured in every newspaper and magazine in Portugal (with the URL written down in print, remember those days?), and I appeared on TV three or four times to talk about it.

The server was a humble machine hosted on my university's network, physically located under my desk. Hosting it on professional data centers was prohibitively expensive back then (clouds in 1999? What's that?). Even hard drives with limited GBs were quite costly, and data exchange was also expensive.

With thousands of people uploading pictures every day, the server's hard drive quickly reached its capacity. I had to limit the number of pictures per user to 100 and restrict picture upload to one per user per day.

This limitation, I believe, was one of the reasons for the website's success - people were forced to choose their best works, leading to a collection of high-quality original content.

## Evolution

I maintained the website as a hobby and never attempted to monetize it. It was a community endeavor that received a lot of assistance from others: I integrated the best ideas, hosted a logo contest, and eventually had a group of people acting as a jury for things like "Best Picture of the Month", "Topic of the Month", "Author of the Month".

The simple website soon housed very active forums, a space to advertise photography-related job openings, interactive boards for posting lists of other photography websites (Google and other search engines were still in their infancy, remember?), and a small section with my own content explaining photographic techniques.

Flash websites were all the rage back then, but I kept foto@pt simple: an efficient interface in pure HTML with my own design. I soon developed an administrative section for managing the website. Unfortunately, from the outset, I made the mistake of thinking I would never need more than one system administrator. As such, I hardcoded my authentication, limiting the webmaster role to just one person: me.

By 2003, there were around 12,000 registered users, with at least 5,000 of them posting daily, amassing more than 100,000 photos on the website. Comments on the photos swelled to 1.5 million.

A rudimentary monitoring system tracked around 15,000 unique visitors per day, amounting to over 8 million unique visitors in three years.

These numbers may seem trivial now, but remember that this was two decades ago. At the time, people with internet access at home were still rare (at least in Portugal), and many websites had public "counters" proudly displaying their visitor numbers - foto@pt was no exception. :)

## Community

Such a large and active community interacted not only on the website but also a lot in real life. I couldn't spare much time for social activity, but community members organized countless photo exhibitions, workshops, photography meetups, walks, lunches, and dinners. All over Portugal (and even in Brazil), members shared their passion for photography.

## Book

In 2001, a unique opportunity arose: one of the website's members was associated with Lisgráfica, a major printing house in Portugal, and offered to sponsor the printing of a book showcasing the website's best works.

This presented another massive project, but I am immensely proud of the achievement. With the assistance of the website's jury, we selected 200 of the best photos from 100 authors and printed 2000 books, featuring high-quality paper and an attractive hardcover sponsored by the publisher (Gótica). The graphic layout work was offered by a company belonging to another website user (eXistenz).

## Jetnet Awards

To illustrate the small scale of the internet in Portugal back then, imagine a yearly competition to recognize the best websites across several categories, like "Information", "Sports", "Culture".

JetNet Awards was such an initiative - the largest in Portugal. It was created in the late 90s by Portugal's biggest ISP, Telepac, which eventually became part of Portugal Telecom.

In its third and final year, 2001, JetNet Awards became quite big. There were 3,500 registered websites, 150,000 unique voters, and prizes given to 21 categories, such as "Best Sports Website," "Best Personal Website," etc. 

Foto@pt twice the prize for "Best Cultural Website", in 2001 and 2002.

The award ceremony was quite an event, televised and held at one of Lisbon's most prestigious theaters, São Luiz Municipal Theater. All the "who's who" of the Portuguese internet were there. The winners received their awards on stage, accompanied by the usual speech.

This event was, without a doubt, the highlight of the website's existence and the recognition of the amazing community that had formed around it.

## The End

By the end of 2002, the website had become too large for me to handle alone. The volume of photos and comments was overwhelming. The administrative tasks had taken over my life. With a full-time job, I found myself unable to dedicate the necessary time to maintain the website. 

An attempt was made to transfer the website's administration to a team of volunteers. However, this didn't work out. Unfortunately, because of my initial design choice to allow only one administrator, delegation was challenging.

In 2003, after much deliberation, I decided to shut down foto@pt. It was a difficult decision and one that broke many hearts, including my own. However, it was necessary given the circumstances. 

## Legacy

Even though foto@pt only existed for a short period, its influence was substantial. It helped pave the way for social networking in Portugal and showed how the internet could bring together people sharing a common passion.

The website may be long gone, but its memory lives on in the many friendships that were formed, the countless photos that were shared, and the vast knowledge that was exchanged. 

In conclusion, foto@pt was a website that started as a simple project but quickly grew into something much larger and more influential. It created a community that shared, learned, and grew together. It was a true pioneer of its time and leaves a legacy that continues to inspire today.

Certainly, here's a condensed version of the section:

## What I Would Have Done Differently

Looking back on the development of foto@pt, there are several lessons I've learned over the past two decades as a software developer, project manager, and product manager:

1. **Language Choice:** I would have chosen PHP over ASP for its longevity and versatility.
2. **Database System:** A more robust database system like Microsoft SQL Server or MySQL would have been a better choice to handle the project's success.
3. **Administrative Area:** A multi-administrator area would have allowed shared responsibility as the project grew.
4. **Code Separation:** Separating the business and presentation layers of the project would have improved maintainability and scalability.
5. **Scalability Planning:** More thought into scalability from the outset could have better prepared the project for its unexpected success.
6. **Community Management:** Implementing robust community management tools and guidelines from the start would have helped manage the active user base.
7. **Monetization Strategy:** Even though the project wasn't intended for monetization, a sustainable financial model could have supported its growth.
8. **Internationalization of Code:** Writing the code in English, including file names, functions, and variables, would have facilitated easier shared work.
9. **Code Comments:** More comments in the code would have made it easier for others to understand, aiding in development and reuse.

These reflections are not regrets but valuable lessons from a pioneering project that helped shape the future of web development.

## Public Code

The code is presented "as is," in its original state from 2003, and is intended to provide a snapshot of early web development practices. Given the historical nature of the project, the codebase might serve as an interesting case study for those interested in the evolution of web technologies.

This repository includes all the ASP code for the website. Please note that this code hasn't been tested for two decades and may contain some non-functional elements due to legacy issues or advancements in technology.

Also included is a ".mdb" file for the Access Database, which is clean of any user data or photo content. Essentially, it's the database schema.

Feel free to use these resources in compliance with the GNU license terms, and don't hesitate to share your past experiences with the website or contribute your technical observations or suggestions related to the code.

## Contact

You can use the Discussions feature here on GitHub for questions, comments, or discussions about the project.

If you're interested in engaging with the existing community or keeping up to date with the project's progress, please visit our [Facebook page](https://www.facebook.com/fotopt/). We look forward to hearing from you!

Contributions to this small piece of history are also welcome. If you have stories, insights, or memories to share, we encourage you to contribute to preserving and enriching the narrative of this pioneering project.

For direct inquiries or more personal discussions, feel free to reach out to me at [tiago@korreio.net](mailto:tiago@korreio.net). I'm always open to engaging in meaningful conversations about this project and its legacy.

## Screenshots

From the WaybackMachine. Missing some images and CSS.

### Homepage

<img width="964" alt="Screenshot 2023-08-02 at 13 30 28" src="https://github.com/korreio/fotopt/assets/97610322/48df9409-8379-4b7a-a9dd-f6364f8fcdb9">

### Sitemap

<img width="774" alt="Screenshot 2023-08-02 at 13 38 12" src="https://github.com/korreio/fotopt/assets/97610322/6e0bd5f9-f8cb-41d7-ad6c-e3c4214859a6">

### Login

<img width="771" alt="Screenshot 2023-08-02 at 13 33 37" src="https://github.com/korreio/fotopt/assets/97610322/31829eed-0a01-4a83-aec5-7135f2abcb89">

### Photographer search

<img width="793" alt="Screenshot 2023-08-02 at 13 34 00" src="https://github.com/korreio/fotopt/assets/97610322/e3bcd420-8bea-479d-ac98-090397860831">

### Photographer galery page

<img width="830" alt="Screenshot 2023-08-02 at 13 40 46" src="https://github.com/korreio/fotopt/assets/97610322/c93bcf47-0f04-4cad-91db-e1db3b67b20c">

### JetNet 2001 Info

<img width="902" alt="Screenshot 2023-08-02 at 13 34 57" src="https://github.com/korreio/fotopt/assets/97610322/12d8b288-0d74-4c6a-94db-2e21831b2844">

### FAQ

<img width="858" alt="Screenshot 2023-08-02 at 13 36 08" src="https://github.com/korreio/fotopt/assets/97610322/0ce11404-dd34-4cad-b7fc-2746520c1bb5">

### Events list

<img width="1108" alt="Screenshot 2023-08-02 at 13 38 57" src="https://github.com/korreio/fotopt/assets/97610322/a9aba44a-12e7-48dd-a14c-f6bc0e85cb8b">

### Changelog and news

<img width="1014" alt="Screenshot 2023-08-02 at 13 39 40" src="https://github.com/korreio/fotopt/assets/97610322/efb84031-5423-4c9d-8687-ca0904c1bef6">

