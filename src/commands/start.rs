use crate::{Context,Error};

#[poise::command(slash_command)]
pub async fn start(ctx: Context<'_>) -> Result<(), Error> {
    let user = ctx.author();
    let response = format!("Welcome to adventure, {}!", user.name);

    ctx.say(response).await?;
    Ok(())
}