The application requires a user to create an account via /signup:
{
    name: string,
    username: string,
    password: string,
    password_confirmation: string
}

Add the received JWT to the Authorization header and then you can view and create your games via the /games endpoints!

games contain the following structure when posting: 
{
    title: string,
    pg: string,
    rating: string
}