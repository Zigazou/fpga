// Déclaration du module
module SimpleVGA (
   input wire clk,
   
   output wire hsync,
   output wire vsync,
   output reg red,
   output reg green,
   output reg blue
);

// Paramètres pour le balayage horizontal
parameter
   horz_front_porch = 11'd800,
   horz_sync_pulse  = 11'd856,
   horz_back_porch  = 11'd976,
   horz_end         = 11'd1040;

// Position X
reg [10:0] xpos = 0;
always @(posedge clk)
   if (xpos == horz_end - 11'd1) xpos <= 11'd0;
   else                          xpos <= xpos + 11'd1;

// Déclenchement de la synchro horizontale
assign hsync = xpos < horz_sync_pulse || xpos >= horz_back_porch;

// Paramètres pour le balayage vertical
parameter
   vert_front_porch = 10'd600,
   vert_sync_pulse  = 10'd637,
   vert_back_porch  = 10'd643,
   vert_end         = 10'd666;

// Position Y
reg [9:0] ypos = 0;
always @(posedge clk)
   if (xpos == horz_end - 11'd1) begin
      if (ypos == vert_end - 10'd1) ypos <= 10'd0;
      else                          ypos <= ypos + 10'd1;
   end

// Déclenchement de la synchro verticale
assign vsync = ypos < vert_sync_pulse || ypos >= vert_back_porch;

// Génération du damier bleu-rouge
always @(posedge clk)
   if (xpos < horz_front_porch && ypos < vert_front_porch) begin
      red <= xpos[5] ^ ypos[5];
      green <= 0;
      blue <= ~xpos[5] ^ ypos[5];
   end else begin
      red <= 0;
      green <= 0;
      blue <= 0;
  end

endmodule

