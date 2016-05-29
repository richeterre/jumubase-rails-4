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

Each annual season of "Jugend musiziert" consists of three rounds:

1. Regionalwettbewerb (RW)
2. Landeswettbewerb (LW)
3. Bundeswettbewerb (BW)

Participants can appear in a given performance in any of the following roles:

1. Soloist
2. Ensemblist
3. Accompanist

There are three possible "genres" or "sub-competitions", the availability of which depends on the contest:

1. Classical (Klassik)
2. Popular (Pop)
3. Kinder musizieren (KiMu)

### Models

__User__
A user of the software, [identified](#authentication) by their email and password.

__Host__
An institution, typically a school, that can host contests.

__Venue__
A physical location, associated with a host, where performances are held.

__Contest__
A single or multi-day event that forms the basic entity of Jugend musiziert. It has a _season_ (= competition year), and a _level_ that corresponds to the competition round (RW, LW or BW).

__Category__
A set of constraints for participating in a contest. There are solo and ensemble categories, e.g. "Violine solo" and "Vokal-Ensemble". Categories also mandate what pieces can be performed, as well as a min/max duration depending on the performance's age group.

__Contest category__
A category when offered within a particular contest. Some contests offer a category only for certain age groups, or not at all.

__Performance__
A musical entry taking place within a contest category, at a given time and venue. It is associated with an age group calculated from the participants' birth dates.

__Appearance__
A single participant's contribution to a performance. Each appearance is awarded points by the jury, and a certificate afterwards.

__Participant__
A person appearing in one or more performances within a contest.

__Instrument__
A musical instrument used in an appearance.

__Piece__
A piece of music presented during a performance. It is associated with a composer or other artist, as well as a musical epoch.

### Authentication

[Devise][devise] is used for user authentication. Users can be associated with one or several hosts, typically for the reason of being employed there and acting as local organizers. They can only manipulate resources "belonging" to those hosts.

Apart from __regular users__ with their host-based access rights, possible user roles include __inspectors__ and __admins__. The former can view but not change anything, while the latter have full privileges.

[devise]: https://github.com/plataformatec/devise

## License

Jumubase is published under the [MIT License][mit-license].

[mit-license]: https://opensource.org/licenses/MIT
