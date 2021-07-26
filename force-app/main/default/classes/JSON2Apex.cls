public class JSON2Apex {
	public Animal animal;

	public class Animal {
		public String id;
		public String name;
		public String eats;
		public String says;
	}

	public JSON2Apex parse(String json) {
		return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
	}
}
