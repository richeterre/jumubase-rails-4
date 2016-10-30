Jumubase
========

Jumubase is a tool for organizers of Germany's largest youth music competition, [Jugend musiziert][jugend-musiziert]. It is designed to eventually replace the closed-source software by the same author that currently powers [jumu-nordost.eu][jumu-nordost], the competition hub for various German schools in Europe.

The application consists of two parts:

* a data management tool accessed via different user and admin accounts
* a JSON API for communicating with future web and mobile clients

[jugend-musiziert]: https://en.wikipedia.org/wiki/Jugend_musiziert
[jumu-nordost]: http://www.jumu-nordost.eu

## Documentation

### Parameters

The following information is unlikely to change often and therefore hard-coded into the software, residing in the `jumu_params.rb` file.

Each annual season of "Jugend musiziert" consists of three __rounds__:

1. Regionalwettbewerb (RW)
2. Landeswettbewerb (LW)
3. Bundeswettbewerb (BW)

When appearing in a performance, a __participant's role__ is any of the following:

1. Soloist
2. Ensemblist
3. Accompanist

There are three possible __"genres" for categories__, the availability of which depends on the contest:

1. Classical (Klassik)
2. Popular (Pop)
3. Kinder musizieren (KiMu)

To denote the __musical epoch of a piece__, the letters _a_ through _f_ are used.

### Models

__User__<br />
A user of the software, [identified](#authentication) by their email and password.

__Host__<br />
An institution, typically a school, that can host contests.

__Venue__<br />
A physical location, associated with a host, where performances are held.

__Contest__<br />
A single or multi-day event that forms the basic entity of Jugend musiziert. It has a _season_ (= competition year), and a _round_ (RW, LW or BW).

__Category__<br />
A set of constraints for participating in a contest. There are solo and ensemble categories, e.g. "Violine solo" and "Vokal-Ensemble". Categories also mandate what pieces can be performed, as well as a min/max duration depending on the performance's age group.

__Contest category__<br />
A category when offered within a particular contest. Some contests offer a category only for certain age groups, or not at all.

__Performance__<br />
A musical entry taking place within a contest category, at a given time and venue. It is associated with an age group calculated from the participants' birth dates.

__Appearance__<br />
A single participant's contribution to a performance. Each appearance is awarded points by the jury, and a certificate afterwards.

__Participant__<br />
A person appearing in one or more performances within a contest.

__Instrument__<br />
A musical instrument used in an appearance.

__Piece__<br />
A piece of music presented during a performance. It is associated with a composer or other artist, as well as a musical epoch.

### Authentication

[Devise][devise] is used for user authentication. Users can be associated with one or several hosts, typically for the reason of being employed there and acting as local organizers. They can only manipulate resources "belonging" to those hosts.

Apart from __regular users__ with their host-based access rights, possible user roles include __inspectors__ and __admins__. The former can view but not change anything, while the latter have full privileges.

[devise]: https://github.com/plataformatec/devise

## License

Jumubase is published under the [MIT License][mit-license].

[mit-license]: https://opensource.org/licenses/MIT
