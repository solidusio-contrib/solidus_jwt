# Changelog

## [v1.2.1](https://github.com/solidusio-contrib/solidus_jwt/tree/v1.2.1) (2023-01-09)

[Full Changelog](https://github.com/solidusio-contrib/solidus_jwt/compare/v1.2.0...v1.2.1)

**Merged pull requests:**

- Bump Solidus Version in Gemspec to Allow Above 3.0 [\#35](https://github.com/solidusio-contrib/solidus_jwt/pull/35) ([cpfergus1](https://github.com/cpfergus1))
- Update to use forked solidus\_frontend when needed [\#34](https://github.com/solidusio-contrib/solidus_jwt/pull/34) ([waiting-for-dev](https://github.com/waiting-for-dev))
- relaxing dependencies for working with solidus v3 [\#33](https://github.com/solidusio-contrib/solidus_jwt/pull/33) ([iLucker93](https://github.com/iLucker93))
- relaxing solidus\_core lower than v3 dependency [\#32](https://github.com/solidusio-contrib/solidus_jwt/pull/32) ([iLucker93](https://github.com/iLucker93))

## [v1.2.0](https://github.com/solidusio-contrib/solidus_jwt/tree/v1.2.0) (2020-06-09)

[Full Changelog](https://github.com/solidusio-contrib/solidus_jwt/compare/v1.0.0...v1.2.0)

**Closed issues:**

- Add helper method for matching user [\#25](https://github.com/solidusio-contrib/solidus_jwt/issues/25)
- Update for solidus\_dev\_support [\#22](https://github.com/solidusio-contrib/solidus_jwt/issues/22)
- Prefer Gem::Version [\#21](https://github.com/solidusio-contrib/solidus_jwt/issues/21)

**Merged pull requests:**

- Upgrade dev environment [\#28](https://github.com/solidusio-contrib/solidus_jwt/pull/28) ([skukx](https://github.com/skukx))
- Add for jwt user method [\#26](https://github.com/solidusio-contrib/solidus_jwt/pull/26) ([skukx](https://github.com/skukx))
- update solidus\_support to 0.5.0 [\#24](https://github.com/solidusio-contrib/solidus_jwt/pull/24) ([ccarruitero](https://github.com/ccarruitero))
- 22 update gem for solidus dev support [\#23](https://github.com/solidusio-contrib/solidus_jwt/pull/23) ([skukx](https://github.com/skukx))
- Handle other Warden strategy errors in API response [\#20](https://github.com/solidusio-contrib/solidus_jwt/pull/20) ([tvdeyen](https://github.com/tvdeyen))
- Change Devise strategy base class [\#19](https://github.com/solidusio-contrib/solidus_jwt/pull/19) ([tvdeyen](https://github.com/tvdeyen))
- Translate error response [\#18](https://github.com/solidusio-contrib/solidus_jwt/pull/18) ([tvdeyen](https://github.com/tvdeyen))
- Fix specs [\#17](https://github.com/solidusio-contrib/solidus_jwt/pull/17) ([tvdeyen](https://github.com/tvdeyen))
- Fix table\_name\_prefix [\#16](https://github.com/solidusio-contrib/solidus_jwt/pull/16) ([tvdeyen](https://github.com/tvdeyen))
- Fix Solidus dependencies [\#15](https://github.com/solidusio-contrib/solidus_jwt/pull/15) ([tvdeyen](https://github.com/tvdeyen))
- Add foreign key to users [\#14](https://github.com/solidusio-contrib/solidus_jwt/pull/14) ([tvdeyen](https://github.com/tvdeyen))
- Remove asset installation [\#13](https://github.com/solidusio-contrib/solidus_jwt/pull/13) ([tvdeyen](https://github.com/tvdeyen))

## [v1.0.0](https://github.com/solidusio-contrib/solidus_jwt/tree/v1.0.0) (2019-12-09)

[Full Changelog](https://github.com/solidusio-contrib/solidus_jwt/compare/v1.0.0.beta2...v1.0.0)

## [v1.0.0.beta2](https://github.com/solidusio-contrib/solidus_jwt/tree/v1.0.0.beta2) (2019-12-04)

[Full Changelog](https://github.com/solidusio-contrib/solidus_jwt/compare/v1.0.0.beta1...v1.0.0.beta2)

**Closed issues:**

- Allow authentication through API? [\#2](https://github.com/solidusio-contrib/solidus_jwt/issues/2)
- Add Refresh Token [\#1](https://github.com/solidusio-contrib/solidus_jwt/issues/1)

## [v1.0.0.beta1](https://github.com/solidusio-contrib/solidus_jwt/tree/v1.0.0.beta1) (2019-11-01)

[Full Changelog](https://github.com/solidusio-contrib/solidus_jwt/compare/v0.1.0...v1.0.0.beta1)

**Merged pull requests:**

- WIP: Implement Refresh Tokens [\#5](https://github.com/solidusio-contrib/solidus_jwt/pull/5) ([skukx](https://github.com/skukx))

## [v0.1.0](https://github.com/solidusio-contrib/solidus_jwt/tree/v0.1.0) (2019-11-01)

[Full Changelog](https://github.com/solidusio-contrib/solidus_jwt/compare/v0.0.2...v0.1.0)

**Closed issues:**

- JWT::InvalidPayload with jwt 2.2.1 [\#9](https://github.com/solidusio-contrib/solidus_jwt/issues/9)
- Prefer using sub claim over id [\#8](https://github.com/solidusio-contrib/solidus_jwt/issues/8)
- Allow claims to be passed through [\#4](https://github.com/solidusio-contrib/solidus_jwt/issues/4)

**Merged pull requests:**

- Update jwt claims [\#11](https://github.com/solidusio-contrib/solidus_jwt/pull/11) ([skukx](https://github.com/skukx))

## [v0.0.2](https://github.com/solidusio-contrib/solidus_jwt/tree/v0.0.2) (2019-06-18)

[Full Changelog](https://github.com/solidusio-contrib/solidus_jwt/compare/v0.0.1...v0.0.2)

**Closed issues:**

- SQLite3::ConstraintException: UNIQUE constraint failed: spree\_users.uid [\#3](https://github.com/solidusio-contrib/solidus_jwt/issues/3)

**Merged pull requests:**

- Fix bug with iat [\#10](https://github.com/solidusio-contrib/solidus_jwt/pull/10) ([skukx](https://github.com/skukx))
- Lock sqlite3 gem version [\#7](https://github.com/solidusio-contrib/solidus_jwt/pull/7) ([mdesantis](https://github.com/mdesantis))
- Calculate 'exp' and 'iat' upon the same timestamp [\#6](https://github.com/solidusio-contrib/solidus_jwt/pull/6) ([mdesantis](https://github.com/mdesantis))

## [v0.0.1](https://github.com/solidusio-contrib/solidus_jwt/tree/v0.0.1) (2018-11-12)

[Full Changelog](https://github.com/solidusio-contrib/solidus_jwt/compare/v0.0.1.pre...v0.0.1)

## [v0.0.1.pre](https://github.com/solidusio-contrib/solidus_jwt/tree/v0.0.1.pre) (2018-10-27)

[Full Changelog](https://github.com/solidusio-contrib/solidus_jwt/compare/3e4c03b72d6259529a8cab3b0def7b338dc7b026...v0.0.1.pre)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
