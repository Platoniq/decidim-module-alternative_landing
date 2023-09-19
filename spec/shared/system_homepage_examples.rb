# frozen_string_literal: true

shared_examples "render all stack block elements" do |type|
  let(:manifest_name) { type.gsub("-", "_") }
  let(:content_block) do
    Decidim::ContentBlock.find_by(organization: organization, manifest_name: manifest_name)
  end

  it "renders all elements" do
    visit decidim.root_path
    expect(page).to have_selector(".alternative-landing.#{type}")
    within ".alternative-landing.#{type}" do
      expect(page).to have_i18n_content(content_block.settings.title)

      1.upto(3) do |item_number|
        within ".stack-item:nth-of-type(#{item_number})" do
          within ".stack-image" do
            # ActiveStorage is generating an url with a different token per session, example:
            # /rails/active_storage/representation/redirect/same-hash--different-token/same-file-name
            # That's why we are splitting by "--" and comparing the first
            img_path = content_block.images_container.attached_uploader("image_#{item_number}".to_sym).path(variant: :landscape)
            img_path && [img_path.split("--").first, img_path.split("/").last].each do |regex|
              expect(page.find("img")[:src]).to match(/#{regex}/)
            end
          end

          if type == "stack-horizontal"
            within ".stack-body" do
              expect(page).to have_i18n_content(content_block.settings.send(:"body_#{item_number}"))

              within ".stack-link" do
                expect(page).to have_i18n_content(content_block.settings.send(:"link_text_#{item_number}"), upcase: true)
                expect(page).to have_selector("a[href='/link?external_url=#{CGI.escape(translated(content_block.settings.send(:"link_url_#{item_number}")))}']")
              end
            end
          else
            within ".stack-tags" do
              expect(page).to have_i18n_content(content_block.settings.send(:"tag_text_#{item_number}"))
              expect(page).to have_selector("a[href='/link?external_url=#{CGI.escape(translated(content_block.settings.send(:"tag_url_#{item_number}")))}']")
            end

            within ".stack-body" do
              expect(page).to have_i18n_content(content_block.settings.send(:"body_#{item_number}"))
            end

            within ".stack-link" do
              expect(page).to have_i18n_content(content_block.settings.send(:"link_text_#{item_number}"), upcase: true)
              expect(page).to have_selector("a[href='/link?external_url=#{CGI.escape(translated(content_block.settings.send(:"link_url_#{item_number}")))}']")
            end
          end
        end
      end
    end
  end
end

shared_examples "render all cover block elements" do |type|
  let(:manifest_name) { type.gsub("-", "_") }
  let(:content_block) do
    Decidim::ContentBlock.find_by(organization: organization, manifest_name: manifest_name)
  end

  it "renders all elements" do
    visit decidim.root_path
    expect(page).to have_selector(".alternative-landing.#{type}")
    # ActiveStorage is generating an url with a different token per session, example:
    # /rails/active_storage/representation/redirect/same-hash--different-token/same-file-name
    # That's why we are splitting by "--" and comparing the first
    img_path = content_block.images_container.attached_uploader(:background_image).path(variant: :big)
    [img_path.split("--").first, img_path.split("/").last].each do |regex|
      expect(page.find(".alternative-landing.#{type}")[:style]).to match(/#{regex}/) if type == "cover-full"
      expect(page.find(".cover-image")[:style]).to match(/#{regex}/) if type == "cover-half"
    end

    within ".alternative-landing.#{type}" do
      within ".cover-text" do
        within ".cover-title" do
          expect(page).to have_i18n_content(content_block.settings.title)
        end
        within ".cover-body" do
          expect(page).to have_i18n_content(content_block.settings.body)
        end
      end
    end
  end
end

shared_examples "render tiles block elements" do
  let!(:tiles_block) { create(:tiles_block, organization: organization) }

  it "renders all elements" do
    visit decidim.root_path
    expect(page).to have_selector(".alternative-landing.tiles-4")
    within ".alternative-landing.tiles-4" do
      within ".tiles" do
        within ".tile-heading" do
          expect(page).to have_i18n_content(tiles_block.settings.title)
        end

        1.upto(4) do |item_number|
          # ActiveStorage is generating an url with a different token per session, example:
          # /rails/active_storage/representation/redirect/same-hash--different-token/same-file-name
          # That's why we are splitting by "--" and comparing the first
          img_path = tiles_block.images_container.attached_uploader("background_image_#{item_number}".to_sym).path(variant: :landscape)
          [img_path.split("--").first, img_path.split("/").last].each do |regex|
            expect(page.find(".tile-#{item_number}")[:style]).to match(/#{regex}/)
          end

          within ".tile-#{item_number}" do
            within ".tile-body" do
              expect(page).to have_i18n_content(tiles_block.settings.send(:"title_#{item_number}"))
              expect(page).to have_i18n_content(tiles_block.settings.send(:"body_#{item_number}"))
            end
          end
        end
      end
    end
  end
end
