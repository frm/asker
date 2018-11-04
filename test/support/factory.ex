defmodule Asker.Factory do
  use ExMachina.Ecto, repo: Asker.Repo

  alias Asker.Accounts.User
  alias Asker.Content.Question

  def user_factory do
    %User{
      slack_id: Faker.String.base64(),
      username: Faker.Internet.user_name()
    }
  end

  def slack_user_factory do
    username = Faker.Internet.user_name()
    first_name = Faker.Name.first_name()
    last_name = Faker.Name.last_name()
    full_name = "#{first_name} #{last_name}"

    %{
      color: Faker.Color.rgb_hex(),
      deleted: false,
      id: Faker.String.base64(),
      is_admin: false,
      is_app_user: false,
      is_bot: false,
      is_owner: false,
      is_primary_owner: false,
      is_restricted: false,
      is_ultra_restricted: false,
      name: username,
      presence: ["online", "away"] |> Enum.random(),
      profile: %{
        avatar_hash: Faker.String.base64(),
        display_name: username,
        display_name_normalized: username,
        email: Faker.Internet.safe_email(),
        fields: [],
        first_name: first_name,
        image_192: Faker.Avatar.image_url(),
        image_24: Faker.Avatar.image_url(),
        image_32: Faker.Avatar.image_url(),
        image_48: Faker.Avatar.image_url(),
        image_512: Faker.Avatar.image_url(),
        image_72: Faker.Avatar.image_url(),
        last_name: last_name,
        phone: Faker.Phone.EnGb.number(),
        real_name: full_name,
        real_name_normalized: full_name,
        skype: "",
        status_emoji: "",
        status_expiration: 0,
        status_text: "",
        status_text_canonical: "",
        team: Faker.String.base64(),
        title: Faker.Company.bullshit()
      },
      real_name: full_name,
      team_id: Faker.String.base64(),
      tz: "Europe/London",
      tz_label: "British Summer Time",
      tz_offset: 3600,
      updated: 1_504_452_720
    }
  end

  def ask_reddit_post_factory do
    %{
      approved_at_utc: nil,
      subreddit: "AskReddit",
      selftext: "",
      author_fullname: "t2_92k5o",
      saved: false,
      mod_reason_title: nil,
      gilded: 0,
      clicked: false,
      title: Faker.Lorem.Shakespeare.hamlet(),
      link_flair_richtext: [],
      subreddit_name_prefixed: "r/AskReddit",
      hidden: false,
      pwls: 6,
      link_flair_css_class: "",
      downs: 0,
      thumbnail_height: nil,
      hide_score: false,
      name: "t3_9oy6cu",
      quarantine: false,
      link_flair_text_color: "light",
      author_flair_background_color: nil,
      subreddit_type: "public",
      ups: 2433,
      domain: "self.AskReddit",
      media_embed: %{},
      thumbnail_width: nil,
      author_flair_template_id: nil,
      is_original_content: false,
      user_reports: [],
      secure_media: nil,
      is_reddit_media_domain: false,
      is_meta: false,
      category: nil,
      secure_media_embed: %{},
      link_flair_text: "",
      can_mod_post: false,
      score: 2433,
      approved_by: nil,
      thumbnail: "self",
      edited: 1_540_828_821.0,
      author_flair_css_class: nil,
      author_flair_richtext: [],
      gildings: %{
        gid_1: 0,
        gid_2: 0,
        gid_3: 0
      },
      content_categories: nil,
      is_self: true,
      mod_note: nil,
      created: 1_539_807_886.0,
      link_flair_type: "richtext",
      wls: 6,
      banned_by: nil,
      author_flair_type: "text",
      contest_mode: false,
      selftext_html: "",
      likes: nil,
      suggested_sort: "top",
      banned_at_utc: nil,
      view_count: nil,
      archived: false,
      no_follow: false,
      is_crosspostable: true,
      pinned: false,
      over_18: false,
      media_only: false,
      link_flair_template_id: "f0882b54-a609-11e2-9cf5-12313b06caaf",
      can_gild: true,
      spoiler: false,
      locked: false,
      author_flair_text: nil,
      visited: false,
      num_reports: nil,
      distinguished: "moderator",
      subreddit_id: "t5_2qh1i",
      mod_reason_by: nil,
      removal_reason: nil,
      link_flair_background_color: "#6ca2c4",
      id: Faker.String.base64(),
      is_robot_indexable: true,
      report_reasons: nil,
      author: Faker.Internet.user_name(),
      num_crossposts: 0,
      num_comments: 6287,
      send_replies: false,
      whitelist_status: "all_ads",
      mod_reports: [],
      author_patreon_flair: false,
      author_flair_text_color: nil,
      permalink: "/r/AskReddit/#{Faker.Internet.slug()}",
      parent_whitelist_status: "all_ads",
      stickied: true,
      url: Faker.Internet.url(),
      subreddit_subscribers: 20_534_179,
      created_utc: 1_539_779_086.0,
      media: nil,
      is_video: false
    }
  end

  def question_factory do
    %Question{
      reddit_id: Faker.String.base64(),
      title: Faker.Company.bullshit(),
      url: Faker.Internet.url()
    }
  end
end
