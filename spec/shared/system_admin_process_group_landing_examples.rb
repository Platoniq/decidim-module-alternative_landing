# frozen_string_literal: true

shared_examples "updates the content block extra title" do
  it "updates the settings of the content block" do
    visit "/admin/participatory_process_groups/#{participatory_process_group.id}/landing_page/content_blocks/extra_title/edit"

    fill_in(
      :content_block_settings_link_text_1_en,
      with: "Custom extra title link text!"
    )
    # rubocop:disable Naming/VariableNumber
    fill_in(
      :content_block_settings_link_url_1,
      with: "https://google.es"
    )
    # rubocop:enable Naming/VariableNumber
    click_button "Update"
    visit decidim_participatory_processes.participatory_process_group_path(participatory_process_group)
    expect(page).to have_content(/Custom extra title link text!/i)
  end
end

shared_examples "updates the content block extra information" do
  it "updates the settings of the content block" do
    visit "/admin/participatory_process_groups/#{participatory_process_group.id}/landing_page/content_blocks/extra_information/edit"

    editor = find(".ql-editor")
    editor.set("Custom extra information body text!")

    fill_in(
      :content_block_settings_columns,
      with: 2
    )

    click_button "Update"
    visit decidim_participatory_processes.participatory_process_group_path(participatory_process_group)
    expect(page).to have_content(/Custom extra information body text!/i)
    expect(page).to have_css(".columns.large-2")
  end
end
