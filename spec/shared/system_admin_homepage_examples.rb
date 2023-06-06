# frozen_string_literal: true

shared_examples "increase number of content blocks" do
  it "increases the number of active content blocks" do
    content_block = find("ul.js-list-availables li", text: text)
    active_blocks_list = find("ul.js-list-actives")
    content_block.drag_to(active_blocks_list)
    sleep(2)
    expect(Decidim::ContentBlock.count).to eq 1
  end
end

shared_examples "updates the content block" do
  it "updates the settings of the content block" do
    visit decidim_admin.edit_organization_homepage_content_block_path(block.to_sym)

    fill_in(
      :content_block_settings_title_en,
      with: "Custom title text!"
    )

    click_button "Update"
    visit decidim.root_path
    expect(page).to have_content("Custom title text!")
  end
end
