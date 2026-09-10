ActiveAdmin.register Customer do
  permit_params :name

  index do
    column :name
    column "Full Cards Completed" do |customer|
      customer.completed_cards_count
    end
    column "Public Link" do |customer|
      link_to "View card", public_card_url(customer.public_token), target: "_blank", rel: "noopener"
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row "Full Cards Completed" do |customer|
        customer.completed_cards_count
      end
      row "Public Link" do |customer|
        link_to public_card_url(customer.public_token), public_card_url(customer.public_token), target: "_blank", rel: "noopener"
      end
    end

    card = customer.active_card

    panel "Active Card — #{card.stamps_count}/10" do
      if card.reward_ready?
        para "✅ Ready for FREE wash"
        span do
          button_to "Claim Free Wash", claim_free_laundry_admin_loyalty_card_path(card),
                    method: :post,
                    form: { onsubmit: "return confirm('Claim the free wash for this customer?')" }
        end
      else
        span do
          button_to "Add Stamp", stamp_admin_loyalty_card_path(card), method: :post
        end
      end

      table_for card.stamps.order(stamped_at: :desc) do
        column "Date" do |stamp|
          stamp.stamped_at.strftime("%Y-%m-%d %H:%M")
        end
        column "Stamped By" do |stamp|
          stamp.admin_user&.email
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end
end
