class SaleDetailsController < ApplicationController
  before_action :get_sale
  before_action :set_sale_detail
  before_action :get_product

   #acomodar para luego incluir ajax y jquery
  def destroy
    precio = @detalle.precio_detalle_venta
    cantidad = @detalle.cantidad
    existencia = @productd.existencia_producto
    total_inicial = @ventad.total_venta
    total_medio = precio * cantidad
    total_final = total_inicial - total_medio
    @ventad.total_venta = total_final
    existencia = existencia + cantidad
    @productd.existencia_producto = existencia
    @productd.save
    @ventad.save
     @detalle.destroy
     respond_to do |format|
       format.html { redirect_back fallback_location: proc { edit_sale_url(@venta) }, notice: "El producto ha sido retirado de la venta" }
      format.json { head :no_content }
      end
  end

  private

  #aqui esta agarrando el param errado como en el proximo metodo
  def get_sale
    @ventad = Sale.find(params[:sale_id])
  end

  def get_product
    producto = @detalle.product.id
    @productd = Product.find(producto)
  end
  #esta agarrando el params de la venta osea que si esta es 23, y el detalle es 27, el 23 sera enviado
  def set_sale_detail
    @detalle = @ventad.sale_details.find(params[:id]) 
  end
  
end
