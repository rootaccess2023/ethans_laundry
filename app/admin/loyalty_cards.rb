ActiveAdmin.register LoyaltyCard do
  actions :index, :show

  member_action :stamp, method: :post do
    if resource.add_stamp!(by: current_admin_user)
      redirect_to admin_customer_path(resource.customer), notice: "Stamp added"
    else
      redirect_to admin_customer_path(resource.customer), alert: "Card is full — claim the free wash first"
    end
  end

  member_action :claim_free_laundry, method: :post do
    if resource.claim_free_laundry!
      redirect_to admin_customer_path(resource.customer), notice: "Free wash claimed — new card issued"
    else
      redirect_to admin_customer_path(resource.customer), alert: "Card isn't ready to claim"
    end
  end
end
